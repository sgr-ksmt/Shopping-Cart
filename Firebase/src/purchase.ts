import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin'
import Document from './document'
import * as Model from './model'

export const purchase = functions
  .runWith({ memory: "1GB", timeoutSeconds: 240 })
  .region('asia-northeast1')
  .https.onCall(async (data, context) => {
    try {
      if (!context.auth || !context.auth.uid) {
        throw new functions.https.HttpsError('unauthenticated', 'User is not authenticated.')
      }
      const user = await admin.firestore().collection('users').doc(context.auth.uid).get()
        .then(s => new Document<Model.User>(s))

      const cartItems = await user.ref.collection('cart_items').get()
        .then(s => s.docs.map(d => new Document<Model.CartItem>(d)))

      if (cartItems.length === 0) {
        throw new functions.https.HttpsError('failed-precondition', 'Cart items must be one or more items.')
      }

      await admin.firestore().runTransaction(async transaction => {
        const promises = []
        for (const cartItem of cartItems) {
          promises.push(transaction.get(cartItem.data.product)
            .then(s => new Document<Model.Product>(s))
            .then(product => {
              if (cartItem.data.quantity <= product.data.stock) {
                transaction.update(product.ref, { stock: product.data.stock - cartItem.data.quantity })
              } else {
                throw new functions.https.HttpsError('failed-precondition', 'There is less stock than the quantity to buy')
              }
            })
          )
        }
        return Promise.all(promises)
      })

      const products = await Promise.all(cartItems
        .map(c => c.data.product.get().then(s => new Document<Model.Product>(s)))
      )
      const order: Model.Order = {
        purchaseTime: admin.firestore.Timestamp.now(),
        snapshotProducts: products.map(product => {
          return {
            id: product.ref.id,
            name: product.data.name,
            desc: product.data.desc,
            price: product.data.price,
            owner: product.data.owner,
            imageURL: product.data.imageURL,
            quantity: cartItems.find(c => c.data.product.path === product.ref.path)!.data.quantity
          }
        })
      }
      const orderRef = user.ref.collection('orders').doc()
      await orderRef.create(order)
      await Promise.all(cartItems.map(cartItem => cartItem.ref.delete()))
      return { orderID: orderRef.id }
    } catch (error) {
      throw error
    }
  })

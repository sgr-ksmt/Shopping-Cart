import * as admin from 'firebase-admin'
import * as Purchase from './purchase'

const serviceAccount = require(`./admin_sdk.json`)
admin.initializeApp({ credential: admin.credential.cert(serviceAccount) })

export const purchase = Purchase.purchase
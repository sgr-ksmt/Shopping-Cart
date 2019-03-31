export interface User {
  name: string
}

export interface CartItem {
  quantity: number
  product: FirebaseFirestore.DocumentReference
}

export interface Product {
  name: string
  desc: string
  price: number
  stock: number
  imageURL: string
  owner: FirebaseFirestore.DocumentReference
}

export interface SnapshotProduct {
  id: string
  name: string
  desc: string
  price: number
  owner: FirebaseFirestore.DocumentReference
  imageURL: string
  quantity: number
}

export interface Order {
  purchaseTime: FirebaseFirestore.Timestamp
  snapshotProducts: SnapshotProduct[]
}

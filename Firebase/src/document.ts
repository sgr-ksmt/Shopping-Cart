export default class Document<T> {
  private snapshot: FirebaseFirestore.DocumentSnapshot
  get ref(): FirebaseFirestore.DocumentReference {
    return this.snapshot.ref
  }
  get data(): T {
    return this.snapshot.data() as T
  }

  constructor(snapshot: FirebaseFirestore.DocumentSnapshot) {
    this.snapshot = snapshot
  }
}
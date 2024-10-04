export default class Person {
    id?: number;
    name?: string;
    birthdate?: string;
    gender?: string;
    signature?: string;
    hobby?: string;
    constructor(id: number, name: string, birthdate: string, gender: string, signature: string, hobby: string) {
        this.id = id;
        this.name = name;
        this.birthdate = birthdate;
        this.gender = gender;
        this.signature = signature;
        this.hobby = hobby;
    }
}

export class User {
    constructor(
        public readonly id: number,
        public email: string,
        public encryptedPassword: string
    ){}

    static async findOne(params: {email:string}) {
        return MOCK__USERS.find((user)=> user.email === params.email || null);
    }
}

export const MOCK__USERS: User[] = [];
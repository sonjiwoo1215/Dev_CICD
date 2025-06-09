import {jest} from '@jest/globals';

const jwt = {
    sign: jest.fn(({email}: {email: string}) => "mock_jwt_" +email),

    verify: jest.fn((token:string)=> {
        if(!token.startsWith("mock_jwt_")){
            throw new Error("Invalid token");
        }
    }),

    decode: jest.fn((token:string) => {
        if(!token.startsWith("mock_jwt_")){
            throw new Error("Invalid token");
        }
        return {email: token.replace("mock_jwt_", "")};
    })
}

export default jwt;
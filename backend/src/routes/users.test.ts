import request from 'supertest';
import {app} from '../app';
import {User, MOCK__USERS} from '../model/__mocks__/user'

jest.mock("../models/user", ()=> jest.requireActual("../model/__mocks__/user"));

afterEach(()=> {
    MOCK__USERS.splice(0, MOCK__USERS.length);
});

describe("GET /users/me", () => {
    test("올바른 쿠키가 설정되어있으면 유저 정보와 함께 200 응답을 받는다", async () => {
        MOCK__USERS.push(new User(1, "apple@example.com", "mock_encrypted_apple123"));
        
        const response = await request(app)
        .get("/users/me")
        .set("Cookie", "access-token=mock_jwt_apple@example.com");

        expect(response.status).toBe(200);
        expect(response.body).toEqual({email: "apple@example.com"})
    })
})
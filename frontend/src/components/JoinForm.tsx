import React from 'react';
import { Form } from 'react-router-dom';

const Container = ({ children }: { children: React.ReactNode }) => <div>{children}</div>;
const Title = ({ children }: { children: React.ReactNode }) => <h1>{children}</h1>;
const InputContainer = ({ children }: { children: React.ReactNode }) => <div>{children}</div>;

export interface JoinFormProps {
    onSubmit?: (e: { email: string; password: string }) => void;
}

export const JoinForm: React.FC<JoinFormProps> = (props) => {
    return (
        <Container>
            <Title>회원가입</Title>
            <Form method="post" onSubmit={(e) => {
                e.preventDefault();
                const formData = new FormData(e.currentTarget);
                const email = formData.get('email') as string;
                const password = formData.get('password') as string;
                props.onSubmit?.({ email, password });
            }}>
                <InputContainer>
                    <label htmlFor="email">이메일</label>
                    <input type="email" name="email" id="email" required />
                </InputContainer>

                <InputContainer>
                    <label htmlFor="password">비밀번호</label>
                    <input type="password" name="password" id="password" required />
                </InputContainer>

                <button type="submit">가입하기</button>
            </Form>
        </Container>
    );
};

import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

const SECRET_KEY = 'your-secret-key';

export async function authenticateUser(req: Request, res: Response, next: NextFunction) {
    const accessToken = req.cookies["access-token"];
    if (!accessToken) {
        return res.sendStatus(401);
    }

    try {
        const decoded = jwt.verify(accessToken, SECRET_KEY);
        req.user = decoded;
        next();
    } catch (err) {
        return res.sendStatus(403);
    }
}

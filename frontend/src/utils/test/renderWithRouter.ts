import {render} from '@testing-library/react';
import React from 'react';
import { BrowserRouter } from 'react-router-dom';

export function renderWithRouter(ui: React.ReactElement, {route = "/"} = {}) {
    window.history.pushState({}, "Test page", route);
    render(ui, {wrapper: BrowserRouter})
}
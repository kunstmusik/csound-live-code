import { ColorModeProvider, ColorModeScript, ThemeProvider } from '@chakra-ui/react'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './index.css'
import theme from './Theme'

console.log(theme.config.initialColorMode);
ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <>
  <React.StrictMode>
    <App />
  </React.StrictMode>
  </>
)

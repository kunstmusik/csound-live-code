import { ColorModeProvider, ColorModeScript, ThemeProvider } from '@chakra-ui/react'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './index.css'
import theme from './Theme'
import "@fontsource/raleway/600.css";

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <>
  <React.StrictMode>
    <App />
  </React.StrictMode>
  </>
)

// always ask before unloading page in case of accidental refresh or other navigation
window.onbeforeunload = function() {
  return "Are you sure?";
};
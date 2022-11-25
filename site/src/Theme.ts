// theme.ts

// 1. import `extendTheme` function
import { extendTheme, StyleFunctionProps, type ThemeConfig } from '@chakra-ui/react'

// 2. Add your color mode config
const config: ThemeConfig = {
  initialColorMode: 'dark',
  useSystemColorMode: false,
}

// 3. extend the theme
const theme = extendTheme({ config, 
    styles: {
        global: (props: StyleFunctionProps) => ({
          body: {
            color: 'default',
            bg: '#272822',
          },
        }),
      } 

})

export default theme
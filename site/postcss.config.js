export default {
  plugins: {
    '@tailwindcss/postcss': {},
    autoprefixer: {}, // autoprefixer is actually included in @tailwindcss/postcss but keeping it is fine or removing it. v4 handles prefixing.
  },
}

/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      fontFamily: {
        'poppins': ['Poppins', 'sans-serif'],
      },
      colors: {
        bg_white: '#f9f9f1',
        
        primary: '#1a1a1a',
        text_light: '#ffffff',
      },
    },
  },
  plugins: [
    require('daisyui'),
  ],
  daisyui: {
    themes: [
      {
        mydarktheme: {
          "primary": "#3b82f6",
          "secondary": "#fbbf24",
          "accent": "#f472b6",
          "neutral": "#3d4451",
          "base-100": "#1a1a1a",
          "info": "#3abff8",
          "success": "#36d399",
          "warning": "#fbbd23",
          "error": "#f87272",
        },
      },
      "light",
    ],
  },
}
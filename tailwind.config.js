module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [require("daisyui")],
  daisyui: {
    themes: [
      {
        meigenotter: {
          "primary": "#00ffff",
          "secondary": "#00d1ff",
          "accent": "#0000ff",
          "neutral": "#dcdcdc",
          "base-100": "#ffffff",
          "info": "#87ceeb",
          "success": "#00ff7f",
          "warning": "#ffd700",
          "error": "#ff0000",
        },
      },
    ],
  },
}

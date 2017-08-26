var path = require('path');
var HtmlWebpackPlugin = require('html-webpack-plugin');

var src = path.resolve(__dirname, 'src');
var build = path.resolve(__dirname, 'build');

module.exports = {
  entry: path.join(src, 'index.jsx'),
  output: {
    path: build,
    filename: 'build.js'
  },
  module: {
    loaders: [
      {
        test: /\.js/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015']
        }
      }, {
        test: /\.jsx/,
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['es2015']
        }
      }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({
      template: path.join(src, 'index.html')
    })
  ]
}

const path = require ('path');

console.log(process.env.NODE_ENV)

const publicDir = path.join (__dirname, '/public');
module.exports = {
  mode: process.env.NODE_ENV || 'development',
  entry: ['./src/index.js'],
  output: {
    path: publicDir,
    publicPath: '/',
    filename: 'bundle.js',
  },
  module: {
    rules: [
      {
        exclude: /node_modules/,
        loader: 'babel-loader',
        query: {
          presets: ['react', 'es2015'],
        },
      },
    ],
  },
  resolve: {
    extensions: ['.js', '.jsx'],
  },
  devServer: {
    port: 3000,
    historyApiFallback: true,
    contentBase: publicDir,
    disableHostCheck: true
  },
};

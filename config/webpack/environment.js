const { environment } = require('@rails/webpacker')

// 既存の設定を確認

// ファイルローダーの設定を追加
environment.loaders.append('file', {
  test: /\.(png|jpe?g|gif|svg|eot|ttf|woff2?)$/i,
  use: [
    {
      loader: 'file-loader',
      options: {
        name: '[path][name].[ext]',
        context: 'app/javascript', // 必要に応じて設定
      },
    },
  ],
})

// Sass ファイルを処理するための設定を追加
const sassLoader = environment.loaders.get('sass');
sassLoader.use.find(item => item.loader === 'sass-loader').options = {
  implementation: require('sass'),
};

module.exports = environment

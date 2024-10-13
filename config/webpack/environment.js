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

module.exports = environment

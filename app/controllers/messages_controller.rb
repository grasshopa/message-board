class MessagesController < ApplicationController
  #メッセージを新規作成する際のフォームを表示するindexアクション
  def index
    #Messageモデルを初期化して@messageに代入→新規作成フォームが表示
    @message = Message.new
    #Messageを全て取得
    @messages = Message.all
  end
  
  #フォームからパラメータを受け取りDBに格納するcreateアクション
  def create
    #パラメータを受取り、Messageインスタンスを生成(Message.new)、@messageに代入
    @message = Message.new(message_params)
    #メッセージモデルのインスタンスをデータベースに保存
    if @message.save
      #メッセージが保存できたとき
      redirect_to root_path , notice: 'メッセージを保存しました。'
    else
      #メッセージが保存できなかったとき
      #→Message.allでテンプレートに使用するインスタンス変数を渡す
      @messages = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました"
      render 'index'
    end
  end
  
  private
  def message_params
    params.require(:message).permit(:name, :body)
  end
  ##ここまで
end

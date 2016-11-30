class MessagesController < ApplicationController
  #（フィルタ機能）アクションの前後に任意の処理をできる→editアクション、updateアクションの前に処理できる
  before_action :set_message, only: [:edit, :update, :destroy]
  
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
  
  def edit
  end
  
  #エラーが※一番下ではエラー
  def destroy
    @message.destroy
    redirect_to root_path, notice: 'メッセージを削除しました'
  end
  
  def update
    if @message.update(message_params)
      #保存に成功した場合はトップページへリダイレクト
      redirect_to root_path , notice: 'メッセージを編集しました'
    else
      #保存に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  private
  def message_params
    params.require(:message).permit(:name, :body)
  end
  
  def set_message
    #RESTという設計 → 求めるしリソースをURL内にあるid番号によって判断、要求されるリソースを特定できる設計
    #※params=フォームから送信したパラメータをコントローラ側に受け取るハッシュだけではない
    @message = Message.find(params[:id])
  end
  
end

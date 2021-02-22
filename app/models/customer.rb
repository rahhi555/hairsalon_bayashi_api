class Customer < ApplicationRecord
  has_many :appointments, dependent: :destroy

  VALID_NAME_REGEX = /\A[^\s　]+　[^\s　]+\z/
  # nameの正規表現。
  # 先頭から空白(全角含む)ではない1字以上 + 全角空白 + 空白(全角含む)ではない1字以上
  # 例）田中　太郎
  VALID_TEL_REGEX = /\A0\d{9,10}\z/
  # telの正規表現。先頭が0から始まり、数字が9か10回続く
  VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i	
  # mailの正規表現。railsチュートリアルのパクリっす。

  validates :name,  presence: {message: "お客様の名前が未入力です"}, 
                    length:   {maximum: 50, message: "お客様の名前は50文字が上限です"},
                    format:   {with: VALID_NAME_REGEX, 
                              message: "名前は真ん中に全角空白を入れ、そこ以外に空白を使用しないでください"}

  validates :tel,   presence:   {message: '電話番号が未入力です'},
                    uniqueness: {message: 'すでに使用されている電話番号です'},
                    format:     {with: VALID_TEL_REGEX, message: '電話番号の形式と一致しません'}

  validates :mail,  presence:   {message: 'メールアドレスが未入力です'},
                    length:     {maximum: 255, message: 'メールアドレスは255文字が上限です'},
                    uniqueness: {message: 'すでに使用されているメールアドレスです'},
                    format:     {with: VALID_MAIL_REGEX, message: 'メールアドレスの形式と一致しません'} 
end

# frozen_string_literal: true

class Stylist < ApplicationRecord
  has_many :appointments, dependent: :restrict_with_error
  belongs_to :rank, optional: true

  VALID_NAME_REGEX = /\A[^\s　]+　[^\s　]+\z/

  VALID_TEL_REGEX = /\A0\d{9,10}\z/

  VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :name,  presence: { message: 'スタイリストの名前が未入力です' },
                    length: { maximum: 50, message: 'スタイリストの名前は50文字が上限です' },
                    format: { with: VALID_NAME_REGEX,
                              message: '名字と名前の間に全角空白を入れ、そこ以外に空白を使用しないでください' }

  validates :tel,   presence: { message: '電話番号が未入力です' },
                    uniqueness: { message: 'すでに使用されている電話番号です' },
                    format: { with: VALID_TEL_REGEX, message: '電話番号の形式と一致しません' }

  validates :mail,  presence: { message: 'メールアドレスが未入力です' },
                    length: { maximum: 255, message: 'メールアドレスは255文字が上限です' },
                    uniqueness: { message: 'すでに使用されているメールアドレスです' },
                    format: { with: VALID_MAIL_REGEX, message: 'メールアドレスの形式と一致しません' }
  
  validates :hire_on, presence: { message: '入社日が未記入です' }

  validates :uid    , presence: { message: 'uidが送信されていません'}

  validates :is_male, inclusion: { in:[true, false] }
                      
end

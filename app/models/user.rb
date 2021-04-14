class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :purchases

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/.freeze
  KANA_REGEX = /\A[ァ-ヶー]+\z/.freeze

  with_options presence: true do
    validates :nickname
    validates :last_name
    validates :first_name
    validates :read_last_name
    validates :read_first_name
    validates :birthday
  end

  validates :password, format: { with: PASSWORD_REGEX, message: 'は半角英数字の組合せで入力してください' }, if: proc { |user|user.password.present?}

  with_options format: { with: KANA_REGEX, message: 'は全角カタカナで入力してください' } do
    validates :read_last_name, if: proc { |user|user.read_last_name.present?}

    validates :read_first_name, if: proc { |user|user.read_first_name.present?}
  end

  with_options format: { with: NAME_REGEX, message: 'は全角日本語で入力してください' } do
    validates :last_name, if: proc { |user|user.last_name.present?}

    validates :first_name, if: proc { |user|user.first_name.present?}
  end
end

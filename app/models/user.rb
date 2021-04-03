class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
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
  validates :password,        format: { with: PASSWORD_REGEX, message: "Use both English and numbers" }, if: Proc.new {|user|user.password.present?}
  validates :read_last_name,  format: { with: KANA_REGEX, message: "Please enter in the full-width katakana" }, if: Proc.new {|user|user.read_last_name.present?}
  validates :read_first_name, format: { with: KANA_REGEX, message: "Please enter in the full-width katakana" }, if: Proc.new {|user|user.read_first_name.present?}
  validates :last_name,       format: { with: NAME_REGEX, message: "Please enter full-width Japanese" }, if: Proc.new {|user|user.last_name.present?}
  validates :first_name,       format: { with: NAME_REGEX, message: "Please enter full-width Japanese" }, if: Proc.new {|user|user.first_name.present?}
end
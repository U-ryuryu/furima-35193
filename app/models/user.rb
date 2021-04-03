class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/

  validates :nickname,        presence: true
  validates :last_name,       presence: true
  validates :first_name,      presence: true
  validates :read_last_name,  presence: true
  validates :read_first_name, presence: true
  validates :birthday,        presence: true
  validates :password,        format: { with: PASSWORD_REGEX, message: "Use both English and numbers" }, if: Proc.new {|user|user.password.present?}
  validates :read_last_name,  format: { with: /\A[ァ-ヶー]+\z/, message: "Please enter in the full-width katakana" }, if: Proc.new {|user|user.read_last_name.present?}
  validates :read_first_name, format: { with: /\A[ァ-ヶー]+\z/, message: "Please enter in the full-width katakana" }, if: Proc.new {|user|user.read_first_name.present?}
  validates :last_name,       format: { with: NAME_REGEX, message: "Please enter full-width Japanese" }, if: Proc.new {|user|user.last_name.present?}
  validates :first_name,       format: { with: NAME_REGEX, message: "Please enter full-width Japanese" }, if: Proc.new {|user|user.first_name.present?}
end
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         # ===== Omniauthを使用するためのオプションを追加 =====
         :omniauthable, omniauth_providers: %i[google_oauth2]
  mount_uploader :avatar, AvatarUploader

  has_many :sns_credentials, dependent: :destroy
  has_many :fetch_ais, dependent: :destroy
  has_many :makes, dependent: :destroy
  has_many :first_parts, dependent: :destroy
  has_many :second_parts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_makes, through: :likes, source: :make

  validates :name, presence: true
  validates :email, uniqueness: true

  class << self # ここからクラスメソッドで、メソッドの最初につける'self.'を省略できる
    # SnsCredentialsテーブルにデータがないときの処理
    def without_sns_data(auth)
      user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else # User.newの記事があるが、newは保存までは行わないのでcreateで保存をかける
        user = User.create(
          name: auth.info.name, # デフォルトから追加したカラムがあれば記入
          email: auth.info.email,
          password: Devise.friendly_token(10) # 10文字の予測不能な文字列を生成する
        )
        sns = SnsCredential.create(
          user_id: user.id,
          uid: auth.uid,
          provider: auth.provider
        )
      end
      { user:, sns: } # ハッシュ形式で呼び出し元に返す
    end

    # SnsCredentialsテーブルにデータがあるときの処理
    def with_sns_data(auth, snscredential)
      user = User.where(id: snscredential.user_id).first
      # 変数userの中身が空文字, 空白文字, false, nilの時の処理
      if user.blank?
        user = User.create(
          name: auth.info.name,
          email: auth.info.email,
          password: Devise.friendly_token(10)
        )
      end
      { user: }
    end

    # Googleアカウントの情報をそれぞれの変数に格納して上記のメソッドに振り分ける処理
    def find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid:, provider:).first
      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = snscredential
      else
        user = without_sns_data(auth)[:user]
        sns = without_sns_data(auth)[:sns]
      end
      { user:, sns: }
    end
  end

  def own?(object)
    id == object&.user_id
  end

  def like(make)
    like_makes << make
  end

  def unlike(make)
    like_makes.destroy(make)
  end

  def like?(make)
    like_makes.include?(make)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name email created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[makes second_parts first_parts]
  end
end

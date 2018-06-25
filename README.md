# NaviHalal 在台清真生活交流平台

> 快速搜尋在附近的餐廳

## 目錄

1. [Information](#information)
2. [Starting](#starting)
3. [Setting](#setting)
    * [devise.rb](#devise)
    * [facebook.yml](#facebook)
4. [Use Fake Data](#use-fake-data)
5. [Website](#website)
## Information
**NaviHalal 提供了以下功能**
### 登入系統
* 使用者不需登入就看到首頁，但使用者和商家一定要登入才能使用網站其他功能。
* 使用者能創建帳號、登入、登出
* 使用者的暱稱不能重覆，若有重覆會跳出錯誤
* 使用者能編輯自己的名稱、介紹、大頭照、國家、居住地、生日
### 首頁
* 使用者不需登入可以瀏覽餐廳，導航自己的位置。
* 瀏覽餐廳、包含收藏數、hashtag
* 搜尋餐廳
* 使用者可以在sidebar進入新增餐廳頁面
* 使用者可以在首頁搜尋餐廳（左上）
* 使用者可以在首頁看到追蹤者的相關通知（右上）
* 追蹤者評論的餐廳
* 追蹤者收藏的餐廳
* 使用者可以在首頁使用自己的side bar（左上左）
* 追蹤者列表
* 收集的餐廳
* 個人主頁
### 新增餐廳
* 使用者可以藉由提供定位，讓網站自動抓取大約的地址
* 使用者可以上傳名稱、電話、營業時間、介紹、照片
### 餐廳show頁面
* 使用者可以瀏覽餐廳照片和相關餐點照片
* 使用者可以瀏覽餐廳的資訊 地址、電話、開店時間
* 使用者可以看到在餐廳底下的留言
* 使用者可以在餐廳底下留言
* 使用者看在這個餐廳hashtag的人數
### 個人頁面
* 使用者可以查看自己搜集的餐廳
* 使用者可以查看追蹤好友列表
### 管理者後台
* 管理者可瀏覽所有餐廳、用戶、tag
* 管理者可新增餐廳、tag
* 管理者可編輯餐廳、tag
* 管理者可刪除餐廳
* 管理者可以修改其他使用者的權限

## Starting
1. 首先將 Rails 專案透過 git clone 下載到本地端(local)︰
```ruby
  $ git clone https://github.com/oklalala/navihalal.git
```
2. 安裝必要的 gems︰
```ruby
  $ bundle install
```
3. 執行 migration 來建立資料表︰
``` ruby
  $ rails db:migrate
```
4. 安裝內建的餐廳資料，與預設的使用者帳號︰
*(Account: 123@123.123, Password: 123123)*
```ruby
  $ rails db:seed
```
5. 將餐廳的經緯度訊息補滿︰
```ruby
  $ rails geocode:all CLASS=Restaurant SLEEP=3 BATCH=10 LIMIT=100
```

## Setting
### devise
為了讓使用者能用 Facebook 登入，當開發環境為本地端時，請在rails專案資料夾 `config/` 新增 `facebook.yml`檔案，
並開啟 `config/initializers/devise.rb` 檔案，啟用下方程式碼，才能在本地端透過 `facebook.yml` 載入串接Facebook API所需要的app_id及secret。

```
  fb_config = Rails.application.config_for(:facebook)
  config.omniauth :facebook,
  fb_config["app_id"],
  fb_config["secret"]
```

### facebook
申請Facebook API金鑰來設定 `facebook.yml` 檔案的內容，請至[facebook for developers](https://developers.facebook.com/apps) 申請並取得app_id、seceret及API token，取得後請在 `facebook.yml` 檔案內輸入以下內容：

```
development:
  app_id: 輸入取得的app_id
  secret: 輸入取得的secret
  api_token: 輸入取得的API token
```

## Use Fake Data
使用 dev.rake 建立假資料，內容包括使用者、追隨清單、hashtag、收藏的餐廳︰
```ruby
  $ rails dev:fake_all
```

## Website
[NaviHalal 在台清真生活交流平台](https://www.navihalal.xyz)

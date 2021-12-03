class HomeController < ApplicationController
    skip_before_action :authenticate_user!
    require 'aws-sdk-s3'

    def top
        if Rails.env == 'development'
            @object_urls = %w(/introduction.png /introduction2.png /introduction3.png)
        else Rails.env == 'production'
            @object_urls =  s3_download
        end
        
    end

    def priporicy
    end

    def confirmable_wait
    end

    private

    def s3_download
        region = 'ap-northeast-1'
        bucket = 'web-spot-image'
        credentials = Aws::Credentials.new(
            ENV['AWS_ACCESS_KEY_ID'],
            ENV['AWS_SECRET_ACCESS_KEY']
        )
        #Awsを初期化の設定。initializeした方が良いかな。
        #Aws.config[:credentials] = credentials
        client = Aws::S3::Client.new(region:region, credentials:credentials)
        objects = client.list_objects(bucket: bucket, max_keys: 3)
        signer = Aws::S3::Presigner.new(client: client)
        
        #S3に保存されている画像の有効期限付きURLを取得する。
        urls = []
        objects.contents.each do |content|
          urls << signer.presigned_url(:get_object, bucket: bucket, key: content.key)
        end

        return urls
    end
end

  

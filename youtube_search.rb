#.envのAPIキーを読み込める様にするgem
require "dotenv/load"
#YouTube検索に利用するGem
require "google/apis/youtube_v3"

# 動画データを取得できるオブジェクトを生成
youtube = Google::Apis::YoutubeV3::YouTubeService.new
#APIキーをオブジェクトのプロパティーに代入
youtube.key = ENV["GOOGLE_API_KEY"]
# q: 検索キーワード   max_results: 検索数
youtube_search_list = youtube.list_searches("id,snippet", type: "video", q: "プログラミング", max_results: 10)

puts youtube_search_list



#チャンネル名・動画タイトル・URLを抽出----------------------
require "dotenv/load"
require "google/apis/youtube_v3"

youtube = Google::Apis::YoutubeV3::YouTubeService.new
youtube.key = ENV["GOOGLE_API_KEY"]
youtube_search_list = youtube.list_searches("id,snippet", type: "video", q: "久保", max_results: 50)

text = ""

youtube_search_list.items.each do |item|
  channel_title = item.snippet.channel_title
  video_title = item.snippet.title
  video_id = item.id.video_id

  text +=<<~EOS
  チャンネルタイトル：#{channel_title}
  タイトル：#{video_title}
  URL：https://www.youtube.com/watch?v=#{video_id}
  iframe：<iframe width="560" height="315" src="https://www.youtube.com/embed/#{video_id}" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
  EOS
end

puts text
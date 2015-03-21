require "bundler"
Bundler.require

INDEX_HTML = File.expand_path("../public/index.html", __FILE__)
COMMENTS_JSON = File.expand_path("../public/comments.json", __FILE__)

def read_comments
  File.read COMMENTS_JSON
end

def add_comment(author:, text:)
  comments = JSON.load(read_comments)
  comments << { author: author, text: text }

  json = JSON.dump(comments)

  File.open(COMMENTS_JSON, "w") do |f|
    f.write json
  end

  json
end

get "/" do
  File.read(INDEX_HTML)
end

get "/comments.json" do
  read_comments
end

post "/comments.json" do
  add_comment(author: params[:author], text: params[:text])
end

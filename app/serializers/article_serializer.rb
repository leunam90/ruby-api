class ArticleSerializer
  include JSONAPI::Serializer
  set_type :article
  attributes :title, :content, :slug
end

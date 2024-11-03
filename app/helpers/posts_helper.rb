module PostsHelper
	def post_thumbnail(post)
		if post.is_a?(Illustration)
		image_tag post.file.variant(resize_to_limit: [400, 300]), class: 'card-img-top', alt: post.title
		elsif post.is_a?(Music)
		content_tag :div, class: 'card-img-top text-center text-muted', style: 'font-size: 100px;' do
			content_tag :i, '', class: 'fas fa-music'
		end
		else
		content_tag :div, class: 'card-img-top text-center text-muted', style: 'font-size: 100px;' do
			content_tag :i, '', class: 'fas fa-file'
		end
		end
	end
end

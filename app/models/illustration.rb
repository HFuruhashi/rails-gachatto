class Illustration < Post
	has_one_attached :file

	validates :file, presence: true, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..5.megabytes }
end

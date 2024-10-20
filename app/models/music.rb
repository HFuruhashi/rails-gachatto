class Music < Post
	has_one_attached :file

	validates :file, presence: true, blob: { content_type: ['audio/mpeg', 'audio/mp3'], size_range: 1..10.megabytes }
end

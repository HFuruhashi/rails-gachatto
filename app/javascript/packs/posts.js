document.addEventListener('DOMContentLoaded', () => {
	const fileInput = document.querySelector('input[type="file"]');
	if (fileInput) {
		const previewArea = document.createElement('div');
		fileInput.parentNode.appendChild(previewArea);

		fileInput.addEventListener('change', (event) => {
			const files = event.target.files;
			previewArea.innerHTML = '';

			if (files && files[0]) {
				const file = files[0];
				if (file.type.startsWith('image/')) {
					const img = document.createElement('img');
					img.src = URL.createObjectURL(file);
					img.style.maxWidth = '300px';
					previewArea.appendChild(img);
				} else if (file.type.startsWith('audio/')) {
					const audio = document.createElement('audio');
					audio.src = URL.createObjectURL(file);
					audio.controls = true;
					previewArea.appendChild(audio);
				}
			}
		});
	}
});

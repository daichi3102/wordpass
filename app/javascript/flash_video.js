document.addEventListener('DOMContentLoaded', function () {
  function loadVideos() {
    const screenWidth = window.innerWidth;
    const desktopWidth = 1024; // Adjust this value based on your responsive design breakpoints

    if (screenWidth >= desktopWidth) {
      const leftVideoContainer = document.getElementById('left-video-container');
      const rightVideoContainer = document.getElementById('right-video-container');

      if (leftVideoContainer) {
        leftVideoContainer.innerHTML = '<video src="/MOlf.mov" alt="Success" class="hidden sm:block h-full mr-2" autoplay loop muted></video>';
      }

      if (rightVideoContainer) {
        rightVideoContainer.innerHTML = '<video src="/MOrf.mov" alt="Success" class="hidden sm:block h-full ml-2" autoplay loop muted></video>';
      }
    }
  }

  // Initial check
  loadVideos();

  // Re-check on window resize
  window.addEventListener('resize', loadVideos);
});

function adjustTimelineLayout() {
  // Only run mobile adjustments on mobile screens
  if (window.innerWidth <= 768) {
    const timelineItems = document.querySelectorAll('.timeline-item');
    let maxYearWidth = 0;
    
    // Find the widest year text
    timelineItems.forEach(item => {
      const yearElement = item.querySelector('.timeline-year');
      if (yearElement) {
        // Create a temporary element to measure text width
        const tempSpan = document.createElement('span');
        tempSpan.style.visibility = 'hidden';
        tempSpan.style.position = 'absolute';
        tempSpan.style.fontSize = window.getComputedStyle(yearElement).fontSize;
        tempSpan.style.fontWeight = window.getComputedStyle(yearElement).fontWeight;
        tempSpan.style.fontFamily = window.getComputedStyle(yearElement).fontFamily;
        tempSpan.textContent = yearElement.textContent;
        
        document.body.appendChild(tempSpan);
        const textWidth = tempSpan.offsetWidth;
        document.body.removeChild(tempSpan);
        
        maxYearWidth = Math.max(maxYearWidth, textWidth);
      }
    });
    
    // Add some padding (20px extra)
    const totalYearWidth = maxYearWidth + 20;
    const timelineLinePosition = totalYearWidth + 10;
    const timelineDotPosition = timelineLinePosition - 6;
    const contentMargin = totalYearWidth + 30;
    
    // Create or update dynamic styles
    let dynamicStyle = document.getElementById('dynamic-timeline-style');
    if (!dynamicStyle) {
      dynamicStyle = document.createElement('style');
      dynamicStyle.id = 'dynamic-timeline-style';
      document.head.appendChild(dynamicStyle);
    }
    
    dynamicStyle.textContent = `
      @media (max-width: 768px) {
        .timeline-container {
          margin-left: -30px !important;
          margin-right: auto !important;
        }
        .timeline-year {
          width: ${totalYearWidth}px !important;
        }
        .timeline-container::before {
          left: ${timelineLinePosition}px !important;
        }
        .timeline-dot {
          left: ${timelineDotPosition}px !important;
        }
        .timeline-content {
          margin-left: ${contentMargin}px !important;
          width: calc(100% - ${contentMargin}px) !important;
        }
      }
      
      @media (max-width: 480px) {
        .timeline-container {
          margin-left: -20px !important;
        }
        .timeline-year {
          width: ${Math.max(totalYearWidth - 5, 50)}px !important;
        }
        .timeline-container::before {
          left: ${Math.max(timelineLinePosition - 5, 45)}px !important;
        }
        .timeline-dot {
          left: ${Math.max(timelineDotPosition - 5, 39)}px !important;
        }
        .timeline-content {
          margin-left: ${Math.max(contentMargin - 5, 75)}px !important;
          width: calc(100% - ${Math.max(contentMargin - 5, 75)}px) !important;
        }
      }
      
      @media (max-width: 360px) {
        .timeline-container {
          margin-left: -15px !important;
        }
        .timeline-year {
          width: ${Math.max(totalYearWidth - 10, 45)}px !important;
        }
        .timeline-container::before {
          left: ${Math.max(timelineLinePosition - 10, 40)}px !important;
        }
        .timeline-dot {
          left: ${Math.max(timelineDotPosition - 10, 36)}px !important;
        }
        .timeline-content {
          margin-left: ${Math.max(contentMargin - 10, 70)}px !important;
          width: calc(100% - ${Math.max(contentMargin - 10, 70)}px) !important;
        }
      }
    `;
  } else {
    // For desktop, remove any left margin adjustments
    let dynamicStyle = document.getElementById('dynamic-timeline-style');
    if (dynamicStyle) {
      dynamicStyle.textContent = '';
    }
  }
}

// Run on page load
document.addEventListener('DOMContentLoaded', adjustTimelineLayout);

// Run on window resize
window.addEventListener('resize', debounce(adjustTimelineLayout, 250));

// Debounce function to limit resize calls
function debounce(func, wait) {
  let timeout;
  return function executedFunction(...args) {
    const later = () => {
      clearTimeout(timeout);
      func(...args);
    };
    clearTimeout(timeout);
    timeout = setTimeout(later, wait);
  };
}
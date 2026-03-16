// Google Analytics tracking code
const GA_MEASUREMENT_ID = 'G-QJ6EXQH8SW';

// Dynamically load gtag script to ensure ID consistency
const script = document.createElement('script');
script.async = true;
script.src = 'https://www.googletagmanager.com/gtag/js?id=' + GA_MEASUREMENT_ID;
document.head.appendChild(script);

window.dataLayer = window.dataLayer || [];
function gtag(){dataLayer.push(arguments);}
gtag('js', new Date());
gtag('config', GA_MEASUREMENT_ID);

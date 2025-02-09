from playwright.sync_api import sync_playwright

def launch_browser():
    """Launches Playwright browser instance"""
    playwright = sync_playwright().start()
    browser = playwright.chromium.launch(headless=True)
    return playwright, browser

def close_browser(playwright):
    """Closes Playwright browser instance"""
    playwright.stop()

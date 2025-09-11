# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Commands

This is a Hugo static site generator project. Common commands:

- `hugo server` - Start development server with live reload
- `hugo server -D` - Start server including draft content
- `hugo` - Build the site (outputs to `public/`)
- `hugo new blog/post-title.md` - Create new blog post
- `hugo new lists/list-name.md` - Create new list page

## Architecture

### Site Structure
- **Content Organization**: All content lives in `content/` with clear sections:
  - `content/blog/` - Blog posts with front matter including tags
  - `content/lists/` - Curated lists and collections
  - `content/tags/` - Tag-based organization
  - `content/_index.md` - Homepage content
  - `content/contact.md` - Contact page

### Layout System
- **Base Template**: `layouts/_default/baseof.html` - Main HTML structure with partials, adds `single-page` class to non-homepage layouts
- **Templates**: 
  - `layouts/index.html` - Homepage with Mondrian grid layout and structured sections (hero, about, projects, blog, media, contact)
  - `layouts/_default/single.html` - Individual page/post layout
  - `layouts/_default/list.html` - List pages (blog index, tag pages)
- **Partials**: Located in `layouts/partials/`
  - `style.html` - Contains all Mondrian CSS with geometric styling, grid layouts, and responsive design
  - `header.html` - Red navigation bar with mobile hamburger menu and JavaScript
  - `footer.html` - Social links (GitHub, Stack Overflow, LinkedIn) with Mondrian button styling
  - `nav.html` - Navigation menu items from hugo.toml configuration
  - `custom_head.html` - Additional head elements

### Styling Approach
- **Piet Mondrian-inspired design** - Geometric grid layout with primary colors (red, blue, yellow) and black borders
- **Full CSS Grid layout** - Homepage uses asymmetrical Mondrian composition with different-sized "windows"
- **CSS Custom Properties** for Mondrian colors: `--mondrian-red: #dc143c`, `--mondrian-blue: #0066cc`, `--mondrian-yellow: #ffcc00`, `--mondrian-black: #000000`, `--mondrian-white: #ffffff`
- **Custom font**: Space Grotesk with bold, uppercase typography for geometric aesthetic
- **Responsive navigation** with mobile hamburger menu maintaining Mondrian styling
- **Single-page layout** for non-homepage content with proper padding and readability

### Content Features
- **Taxonomies**: Tags system configured in `hugo.toml`
- **Permalinks**: Custom URL structure for blog posts (`/blog/:slug/`)
- **Shortcodes**: Custom shortcode for newsletter signup
- **Static Assets**: Images, fonts, and resume files in `static/`

### Site Configuration
- **Base URL**: https://arashtaher.com
- **Hugo Config**: `hugo.toml` with taxonomies, permalinks, and SEO settings
- **SEO**: Configured with Open Graph, Twitter Cards, and structured data templates

### Content Management
- Blog posts use standard Hugo front matter with title, date, and tags
- Lists section for curated content collections  
- Resume available as static HTML in `static/resume/`
- Support for both English content and references to Farsi blog

## Important Notes
- **Mondrian Design System**: Homepage uses CSS Grid with specific color assignments - Hero (white), About (yellow), Projects (yellow), Recent Posts (blue), Podcasting (white), Contact (blue), Navigation (red), Footer (red)
- **Responsive Navigation**: Mobile menu with hamburger toggle and JavaScript functionality in header.html
- **Single Page Class**: Non-homepage layouts automatically get `single-page` class for proper content formatting
- **Newsletter Integration**: Styled newsletter signup form in Mondrian white container with black borders
- Site uses Highlight.js for syntax highlighting (Hugo's built-in highlighting is disabled)
- Public directory is git-ignored and generated on build
- Font files stored locally in static/fonts/ directory
# Why `src/` "doesn't upload" on GitHub Web

GitHub's **web upload** is picky about folders.

## ✅ Works
- Open your repository page → **Add file → Upload files**
- In your file explorer, open the project folder so you can see `pom.xml`, `mvnw`, and `src/`
- **Drag & drop everything** (including the `src/` folder) into the upload area

## ❌ Often fails
- Clicking **Choose your files** and trying to select a folder
- Uploading a `.zip` file (GitHub does **not** unzip it for you)

## Best option
Use Git (command line) or GitHub Desktop. Then `src/` is guaranteed to be included.

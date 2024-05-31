provider "google" {
    project = "shareli-gemini-2024"
    region = "asia-northeast1-b"
    credentials = file("${{ secrets.TERRAFORM_KEY }}")
}

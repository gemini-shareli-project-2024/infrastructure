provider "google" {
    project = "shareli-gemini-2024"
    region = "asia-northeast1-b"
    credentials = "${{ secrets.TERRAFORM_KEY }}"
}

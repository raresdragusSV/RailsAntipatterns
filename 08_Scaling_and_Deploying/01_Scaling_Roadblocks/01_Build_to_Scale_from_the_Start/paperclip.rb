# On a single server
has_attached_file(
  :image,
  styles: {
    medium: '290x290>',
    thumb: '64x64#'
  }
)

# On S3

has_attached_file(
  :image,
  styles: {
    medium: '290x290>',
    thumb: '64x64#'
  },
  storage: :s3,
  s3_credentials: "#{Rails.root}/config/s3.yml",
  path: ':class/:id/:style/:basename.:extension',
  bucket: "post-attachment-images-#{Rails.env}"
)

# Maximum Occupancy

# On a single server
has_attached_file(
  :image,
  styles: {
    medium: '290x290>',
    thumb: '64x64#'
  },
  path: ':rails_root/public/:class/:id_partition/:style/:basename.:extension',
  url: '/:class/:id_partition/:style/:basename.:extension'
)

# On S3

has_attached_file(
  :image,
  styles: {
    medium: '290x290>',
    thumb: '64x64#'
  },
  storage: :s3,
  s3_credentials: "#{Rails.root}/config/s3.yml",
  path: ':class/:id_partition/:style/:basename.:extension',
  bucket: "post-attachment-images-#{Rails.env}"
)

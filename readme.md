# NixOS Digital Ocean Image

This flake provides a NixOS configuration to create a custom Digital Ocean droplet image. 
The generated image is cloud-init compatible and will automatically configure itself using 
the metadata Digital Ocean provides during droplet creation

## Usage

Build the image:

```
nix build .
```

Check that the image is present in the result directory:

```
ls result/
```

Upload the generated image to Digital Ocean [Custom Images](https://cloud.digitalocean.com/images/custom_images)

Create a new droplet and select your NixOS custom image


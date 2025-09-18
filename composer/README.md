Composer packages
===

This directory stores private packages or ready-made artifacts.

Example of configuring the `composer.json` file in the project root:

```json
{
  "repositories": [
    {
      "type": "artifact",
      "url": "composer/artifacts/"
    },
    {
      "type": "path",
      "url": "composer/packages/*"
    }
  ]
}
```

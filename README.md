# Upload tag to url

This action uploads the zip file from a tag version to a custom url.

The zip file uploaded is the one from this pattern:
```
https://github.com/{$GITHUB_REPOSITORY}/archive/refs/tags/{TAG_VERSION}.zip
```

## Inputs

| Name                      | Type    | Description                                                                                         |
|---------------------------|---------|-----------------------------------------------------------------------------------------------------|
| `github_token`            | String  | Github Token                                                                                        |
| `to_url`                  | String  | The URL that will be accessed to receive the file                                                   |
| `url_params`              | Json    | Any custom URL params                                                                               |
| `tag_version`             | String  | The tag version. If empty, will get the tag version just released.                                  |
| `file_param`              | String  | The URL param used to send the zip file                                                             |
| `filename`                | String  | The filename from the zip file. Default is `{$repository}-{tag}`                                    |
| `filename_ext`            | String  | The extension from the zip file. Default is `zip`                                                   |

## Outputs

### `response`

Response from the url

#### Example usage

```yml
- name: Response
      run: echo Response from URL - ${{ steps.release.outputs.response }}
```

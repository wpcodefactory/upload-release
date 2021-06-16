# Upload tag to url

A Github action that uploads the zip file from a tag version to a custom url.

The zip file uploaded is the one from this pattern:
```
https://github.com/{$GITHUB_REPOSITORY}/archive/refs/tags/{TAG_VERSION}.zip
```

## Example Workflow Files

To get started, you will want to copy the contents of one of these examples into `.github/workflows/deploy.yml` and push that to your repository. You are welcome to name the file something else.

### Simple setup

```yml
on:
  push:
    tags:
    - "*"
jobs:
  upload-tag:
    runs-on: ubuntu-latest
    name: Upload Tag
    steps:

    - name: Upload
      uses: wpcodefactory/upload-tag-to-url@v1.0.0
      id: release
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}        
        to_url: 'http://the-url-receiving-the-file'
        file_param: 'custom_file_param'
```


### A more complete setup

```yml
on:
  push:
    tags:
    - "*"
jobs:
  upload-tag:
    runs-on: ubuntu-latest
    name: Upload Tag
    steps:

    - name: Upload
      uses: wpcodefactory/upload-tag-to-url@v1.0.0
      id: release
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        filename: 'zipped-tag-file'
        filename_ext: 'zip'        
        to_url: 'http://the-url-receiving-the-file'
        file_param: 'custom_file_param'
        url_params: '{ "custom_var":"value", "custom_sensitive_variable": "${{ secrets.CUSTOM_SECRET }}"}'
    
    - name: Response
      run: echo Response from URL - ${{ steps.release.outputs.response }}
```

## Inputs

| Name                      | Type    | Description                                                                                         |
|---------------------------|---------|-----------------------------------------------------------------------------------------------------|
| `github_token`            | String  | Github Token                                                                                        |
| `to_url`                  | String  | The URL that will be accessed to receive the file                                                   |
| `url_params`              | Json    | Any custom URL params you might want to send                                                        |
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

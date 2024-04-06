import os, shutil

src_folder = "cypress/e2e"
dst_folder = os.path.join(src_folder, "deployed")

if not os.path.exists(dst_folder):
    os.makedirs(dst_folder)


def replace_content(filename):
    with open(filename, "r") as file:
        filedata = file.read()
    newData = filedata.replace(
        "http://localhost:3000", "http://192.168.222.107:8080"
    ).replace("../../", "../../../")
    with open(filename, "w") as file:
        file.write(newData)


for filename in os.listdir(src_folder):
    if filename.endswith("cy.ts"):
        base_name = filename.replace(".cy.ts", "")
        new_name = base_name + "Deployed.cy.ts"
        shutil.copy(
            os.path.join(src_folder, filename), os.path.join(dst_folder, new_name)
        )
        replace_content(os.path.join(dst_folder, new_name))

print("Files copied and updated successfully!")

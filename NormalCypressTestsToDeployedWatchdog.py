import os, shutil
from watchdog.observers import Observer
from watchdog.events import FileSystemEventHandler

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


def process_file(filename):
    if filename.endswith("cy.ts"):
        base_name = filename.replace(".cy.ts", "")
        new_name = base_name + "Deployed.cy.ts"
        shutil.copy(
            os.path.join(src_folder, filename), os.path.join(dst_folder, new_name)
        )
        replace_content(os.path.join(dst_folder, new_name))


class MyHandler(FileSystemEventHandler):
    def on_modified(self, event):
        if (
            not event.is_directory
            and event.src_path.startswith(src_folder)
            and "deployed" not in event.src_path
        ):
            relative_path = os.path.relpath(event.src_path, src_folder)
            process_file(relative_path)

    def on_created(self, event):
        if (
            not event.is_directory
            and event.src_path.startswith(src_folder)
            and "deployed" not in event.src_path
        ):
            relative_path = os.path.relpath(event.src_path, src_folder)
            process_file(relative_path)


event_handler = MyHandler()
observer = Observer()
observer.schedule(event_handler, path=src_folder, recursive=True)

print("Monitoring started...")
observer.start()

try:
    while True:
        pass
except KeyboardInterrupt:
    observer.stop()
observer.join()

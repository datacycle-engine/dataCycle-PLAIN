# dataCycle - PLAIN

This repository can be used as a basis for specific dataCycle instances and experiments. It only contains the essential dependencies and configuration in order to provide a slim base.

## Setup

* Install [Docker](https://docs.docker.com/get-docker/) (including the docker compose plugin)
* Checkout dataCycle PLAIN and its dependencies:
  `git clone --recurse-submodules git@github.com:datacycle-engine/dataCycle-PLAIN.git`
* Prepare individual environment configuration (`cp .env.example .env`)
* Start dataCycle:
  `docker compose up`
* Watch console output and save superadmin credentials
* Open [http://localhost:3000/](http://localhost:3000/)

## License

dataCycle is released under the [GNU Affero General Public License](https://www.gnu.org/licenses/agpl-3.0-standalone.html)

import axios from 'axios';
import React, { useState, useEffect, Fragment } from 'react';
import Pagination from 'reactjs-hooks-pagination';

const Dashboard = () => {
  const [jobs, setJobs] = useState([]);
  useEffect(() => {
    axios.get('/v1/jobs')
      .then(resp => {
        setJobs(resp.data.data);
      })
      .catch(error => {
        console.log(error);
      });
  }, [jobs.length]);

  const list = jobs.map((job) => {
    const { id, state, finish_at, entry_time } = job.attributes;
    const { client, plumbers } = job.relationships;
    const plumberNames = plumbers.map(plumber => {
      return plumber.name
    });

    return (
      <tr>
        <th scope="row">{id}</th>
        <td>{client.name}</td>
        <td>{client.address}</td>
        <td>{plumberNames.join(', ')}</td>
        <td>{entry_time}</td>
        <td>{finish_at}</td>
        <td>{state}</td>
        <td></td>
      </tr>
    );
  });

  const onChangePage = () => {

  }

  return (
    <Fragment>
      <div className="container">
        <h1>Scheduler</h1>
        <table class="table table-striped">
          <thead>
            <tr>
              <th scope="col">ID</th>
              <th scope="col">Client</th>
              <th scope="col">Address</th>
              <th scope="col">Plumbers</th>
              <th scope="col">Entry</th>
              <th scope="col">Finish at</th>
              <th scope="col">Status</th>
              <th scope="col"></th>
            </tr>
          </thead>
          <tbody>
            {list}
          </tbody>
        </table>

        <div className="d-flex flex-row py-4 justify-content-end">
          <Pagination
            totalRecords={5}
            pageLimit={20}
            pageRangeDisplayed={1}
            onChangePage={onChangePage}
          />
        </div>
      </div>
    </Fragment>
  );
};

export default Dashboard;
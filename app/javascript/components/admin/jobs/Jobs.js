import React, { useState, useEffect, Fragment } from 'react';
import RequestClient from '../../../helpers/RequestClient';
import Pagination from 'reactjs-hooks-pagination';

const Jobs = () => {
  const [jobs, setJobs] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const [totalPages, setTotalPages] = useState(10);
  const [perPage, setPerPage] = useState(20);

  useEffect(() => {
    RequestClient({ method: 'GET' }).get('jobs')
      .then(resp => {
        const { data, paging } = resp.data

        setJobs(data);
        // setTotalPages(paging.total);
        // console.log(totalPages)
        // setCurrentPage(paging.number);
        // setPerPage(paging.size);

      })
      .catch(error => {
        console.log(error);
      });
  }, [jobs.length]);

  const list = jobs.map((job) => {
    const { id, state, finish_at, entry_time } = job.attributes;
    const { client, plumbers } = job.relationships;
    const plumberNames = plumbers.map(plumber => {
      const plumberDetailUrl = `plumbers/${plumber.id}`;
      return <a href={plumberDetailUrl}>{plumber.name}</a>;
    });

    const clientDetailUrl = `clients/${client.id}`;

    return (
      <tr key={id}>
        <th scope="row">{id}</th>
        <td><a href={clientDetailUrl}>{client.name} </a></td>
        <td>{client.address}</td>
        <td>{plumberNames}</td>
        <td>{entry_time}</td>
        <td>{finish_at}</td>
        <td>{state}</td>
        <td></td>
      </tr>
    );
  });

  const onChangePage = (e) => {

  }

  return (
    <Fragment>
      <div className="container">
        <h1>Scheduler</h1>
        <table className="table table-striped">
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
    </Fragment >
  );
};

export default Jobs;
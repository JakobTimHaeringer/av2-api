#/usr/bin/bash

conda activate /home/haj3st/miniconda3/envs/av2/envs/av2

echo "Creating map overview and scenario video visualisation!"

# Dataroot
dataroot='/mnt/ssd/tagged_trajectory_prediction_artifacts/2024_04_15_argoverse_processed/'

# List of scenario directories
scenario_ids=(
    "cad8bece-55c2-470b-ace0-a0ca5f4dcf81/"
    "4a48d594-76ef-4c47-bbf1-48f1d165a25e/"
    "edb4a899-ee6d-4b24-b521-76ad44fc21fc/"
    "abbf06c4-f659-48ec-9965-178077161465/"
    "1bf910db-0ff4-4d14-be49-114e3b1df7a5/"
    "eb3d913c-3deb-40f3-94c4-b591157dda36/"
    "f5c6441c-fd57-4f21-8c7b-8d55b74673b3/"
    "5ffc0504-aa1b-4f84-aedf-064ae0d58aac/"
    "9e593b3a-23b3-49c4-9d2e-55649328caa3/"
    "d6961a3c-e5ff-43e5-9564-79c531b28215/"
    "8124fcd2-0d7f-4a57-b876-8ba9bbba5afe/"
    "71f93cdf-073c-4445-9e79-fb4df79fef3a/"
)

output_dir='/home/haj3st/av2-api/results/focal_tracks_greater_25'

# Loop through the scenario directories
for dir in "${scenario_ids[@]}"
do
    full_dir="${dataroot}${dir}"
    python3 /home/haj3st/av2-api/src/generate_forecasting_scenario_visualizations.py --argoverse-scenario-dir "$full_dir" --viz-output-dir "$output_dir"
    python3 /home/haj3st/av2-api/src/generate_map_overview.py --argoverse-scenario-dir "$full_dir" --viz-output-dir "$output_dir"
done

echo "Map overview and scenario video visualisation has been created!"